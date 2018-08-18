% 8 Queens Problem implementation for ASP with smodels
% 8x8-Field (rows & columns)
num(1..8).

% 8 queens shall be placed on the 8x8-Field
8{ p(R, C) }8 :- num(R), num(C).

% Diagonals (3rd denial)
% Main diagonal & parallels indices p(I, J) with J - I = K
%       for K=-(n-1),-(n-2),..,n-2,n-1 (n=8 --> K=-7,-6,..,6,7)
k_diags(-7..7).
diags(I, J, K) :- num(I), num(J), k_diags(K), K = J - I.
% Antidiagonals indices p(I, J) with I + J = K
%       for K from K=2,3,..,2*n (n=8 --> K=2,3,..,16)
k_antidiags(2..16).
antidiags(I, J, K) :- num(I), num(J), k_antidiags(K), K = I + J.


% Denials:
% 1. Not two queens can be in the same row
:- num(R), num(C1), num(C2), p(R, C1), p(R, C2), C1 != C2.
% 2. Not two queens can be in the same column
:- num(C), num(R1), num(R2), p(R1, C), p(R2, C), R1 != R2.
% 3a. Not two queens can be in the same maindiagonal or in the same parallel
:- num(R1), num(R2), num(C1), num(C2), p(R1, C1), p(R2, C2), C1 != C2, R1 != R2,
    diags(R1, C1, K), diags(R2, C2, K).
% 3b. Not two queens can be in the same antidiagonal
:- num(R1), num(R2), num(C1), num(C2), p(R1, C1), p(R2, C2), C1 != C2, R1 != R2,
    antidiags(R1, C1, K), antidiags(R2, C2, K).
