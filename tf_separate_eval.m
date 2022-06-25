if M_0 > 1
    eq(7) = [];
else
    eq(8) = [];
end

syms ratios;
eq = subs(eq);
eq2 = eq;
while true
    sol = 0;
    for i = 1:length(eq)
        free_vars = symvar(eq(i));
        if length(free_vars) == 1
            %string(eq(i))
            %eq(i)
            eval(strcat(string(symvar(eq(i))), "=", string(vpasolve(eq(i), symvar(eq(i)))), ";"));
            if debug
                disp(symvar(eq(i)) == vpasolve(eq(i), symvar(eq(i))))
            end
            eq(i) = [];
            sol = sol + 1;
            break
        end
        if length(free_vars) == 2
            try
                ratio = free_vars(2) / free_vars(1);
                value = isolate(eq(i), ratio);
                if rhs(value) < rhs(isolate(eq(i), ratio^-1))
                    value = isolate(eq(i), ratio^-1);
                    ratio = ratio^-1;
                end
                if debug
                    disp(value)
                end
                eq = subs(eq, ratio, rhs(value));
                ratios(length(ratios) + 1, 1) = value;
                eq(i) = [];
                sol = sol + 1;
                break;
            end
        end
    end
    if sol == 0 
        break 
    else
        eq = subs(eq);
    end
end
ratios(1) = [];