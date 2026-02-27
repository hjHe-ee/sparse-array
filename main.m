%% Sparse Linear Array Layout Demo (MRA / Coprime / Nested / Random)
clear; clc; close all;

%% ------------------ User Parameters ------------------
d = 1;                 % unit spacing (normalized). e.g., set d = 0.5 for lambda/2
N_total = 10;          % total physical sensors for Coprime/Nested/Random
L_aperture = 24;       % aperture length on integer grid (max position index)

% Coprime parameters (M and N must be coprime; total sensors ~= M+N-1)
M = 4; N = 7;          % gcd(M,N)=1, total sensors = M+N-1 = 10 (matches N_total)

% Nested parameters (N1 dense + N2 sparse => total = N1+N2)
N1 = 4; N2 = 6;        % total = 10 (matches N_total)

% Random sparse parameters
rng_seed = 2;
min_gap = 1;           % minimum index gap between chosen sensors (>=1)

% MRA parameters (keep small for brute force)
N_mra = 10;             % MRA sensors (can be different from N_total)
Lmax_mra = L_aperture; % search up to this aperture on integer grid
%% -----------------------------------------------------

%% 1) MRA (brute-force search on integer grid)
pos_mra = mra_bruteforce_integer(N_mra, Lmax_mra);

%% 2) Coprime array (two subarrays union)
% Subarray A: N elements with spacing M*d => {0, M, 2M, ..., (N-1)M}*d
% Subarray B: M elements with spacing N*d => {0, N, 2N, ..., (M-1)N}*d
pos_coprime = unique([ (0:N-1)*M, (0:M-1)*N ]) * d;

%% 3) Nested array (classic nested)
% Dense: {0,1,...,N1-1}*d
% Sparse: {N1, 2N1, ..., N2*N1}*d
pos_nested = unique([ 0:(N1-1), (1:N2)*N1 ]) * d;

%% 4) Random sparse array (fixed aperture on integer grid)
pos_random = random_sparse_integer(N_total, L_aperture, min_gap, rng_seed) * d;

%% Plot layouts
figure('Color','w'); tiledlayout(2,2,'Padding','compact','TileSpacing','compact');

nexttile;  plot_layout(pos_mra,    'MRA (Min. Redundancy), integer-grid search');
nexttile;  plot_layout(pos_coprime,'Coprime Array');
nexttile;  plot_layout(pos_nested, 'Nested Array');
nexttile;  plot_layout(pos_random, 'Random Sparse Array');







