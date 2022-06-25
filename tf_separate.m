syms a_0
syms c_pc c_pt
syms e_c e_f e_t
syms f
syms F
syms FR
syms g_c
syms h_PR
syms m_dot_0
syms M_0 M_9 M_19
syms P_0 P_9 P_t9 P_19 P_t19 
syms R_c R_t
syms S
syms T_0 T_t4 T_9 T_19
syms V_0 V_9 V_19

syms alpha
syms gamma_c gamma_t
syms eta_r eta_c eta_f eta_b eta_m eta_t eta_P eta_T eta_O
syms pi_r pi_d pi_dmax pi_c pi_f pi_t pi_b pi_n pi_fn
syms tau_r tau_gamma tau_c tau_f tau_lambda tau_t

eq = [
    R_c == (gamma_c - 1) / gamma_c * c_pc * 778.18; % CONVERSION
    R_t == (gamma_t - 1) / gamma_t * c_pt * 778.18; % CONVERSION
    a_0 == sqrt(gamma_c * R_c * g_c * T_0);
    V_0 == a_0 * M_0;
    tau_r == 1 + (gamma_c - 1) / 2 * M_0^2;
    pi_r == tau_r^(gamma_c / (gamma_c - 1));
    eta_r == 1; % for M_0 <= 1
    eta_r == 1 - 0.075 * (M_0 - 1)^1.35; % for M_0 > 0
    pi_d == pi_dmax * eta_r;
    tau_lambda == (c_pt * T_t4) / (c_pc * T_0);
    tau_c == pi_c^((gamma_c - 1) / (gamma_c * e_c));
    eta_c == (pi_c^((gamma_c - 1)/gamma_c) - 1) / (tau_c - 1);
    tau_f == pi_f^((gamma_c - 1)/(gamma_c * e_f));
    eta_f == (pi_f^((gamma_c - 1)/gamma_c) - 1) / (tau_f - 1);
    f == (tau_lambda - (tau_r * tau_c)) / ((eta_b * h_PR)/(c_pc * T_0) - tau_lambda);
    tau_t == 1 - 1 / (eta_m * (1 + f)) * (tau_r / tau_lambda) * (tau_c - 1 + alpha * (tau_f - 1));
    pi_t == tau_t^(gamma_t / ((gamma_t - 1) * e_t));
    eta_t == (1 - tau_t) / (1 - tau_t^(1 / e_t));
    P_t9 / P_9 == P_0 / P_9 * pi_r * pi_d * pi_c * pi_b * pi_t * pi_n;
    M_9 == sqrt(2 / (gamma_t - 1) * ((P_t9 / P_9)^((gamma_t - 1) / gamma_t) - 1));
    T_9 / T_0 == (tau_lambda * tau_t) / ((P_t9 / P_9)^((gamma_t - 1) /gamma_t)) * c_pc / c_pt;
    V_9 / a_0 == M_9 * sqrt((gamma_t * R_t * T_9) / (gamma_c * R_c * T_0));
    P_t19 / P_19 == P_0 / P_9 * pi_r * pi_d * pi_f * pi_fn;
    M_19 == sqrt(2 / (gamma_c - 1) * ((P_t19 / P_19)^((gamma_c - 1) / gamma_c) - 1));
    T_19 / T_0 == (tau_r * tau_f) / ((P_t19 / P_19)^((gamma_c - 1) /gamma_c));
    V_19 / a_0 == M_19 * sqrt(T_19 / T_0);
    F / m_dot_0 == 1 / (1 + alpha) * a_0 / g_c * ((1 + f) * V_9 / a_0 - M_0 + (1 + f) * ((R_t * T_9 / T_0) / (R_c * V_9 / a_0)) * (1 - P_0 / P_9) / gamma_c) + alpha / (1 + 1 * alpha) * a_0 / g_c * (V_19 / a_0 - M_0 + (T_19 / T_0) / (V_19 / a_0) * (1 - P_0 / P_19) / gamma_c);
    S == f / ((1 + alpha) * F / m_dot_0) * 3600; % CONVERSION
    FR == ((1 + f) * V_9 / a_0 - M_0 + (1 + f) * (R_t * T_9 / T_0) / (R_c * V_9 / a_0) * (1 - P_0 / P_9) / gamma_c) / (V_19 / a_0 - M_0 + (T_19 / T_0) / (V_19 / a_0) * (1 - P_0 / P_19) / gamma_c);
    eta_P == (2 * M_0 * ((1 + f) * V_9 / a_0 + alpha * (V_19 / a_0) - (1 + alpha) * M_0)) / ((1 + f) * (V_9 / a_0)^2 + alpha * (V_19 / a_0)^2 - (1 + alpha) * M_0^2);
    eta_T == (a_0^2 * ((1 + f) * (V_9 / a_0)^2 + alpha * (V_19 / a_0)^2 - (1 + alpha) * M_0^2)) / (2 * g_c * f * h_PR) / 778.16; % CONVERSION
    eta_O == eta_P * eta_T
];