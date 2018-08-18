%  1 2 3 4 5 6 7 8 9
%1   3
%2       1 9 5
%3     8         6
%4 8       6 
%5 4     8         1
%6         2
%7   6         2 8
%8       4 1 9     5
%9               7
 

p(1, 2, 3).
p(2, 4, 1). p(2, 5, 9). p(2,6,5).
p(3, 3, 8). p(3, 8, 6).
p(4, 1, 8). p(4, 5, 6).
p(5, 1, 4). p(5, 4, 8). p(5, 9, 1).
p(6, 5, 2).
p(7, 2, 6). p(7, 7, 2). p(7, 8, 8).
p(8, 4, 4). p(8, 5, 1). p(8, 6, 9). p(8, 9, 5).
p(9, 8, 7).
 
 
% rows & columns:
num(1..9).
 
% same square:
ssq(1,2). ssq(1,3). ssq(2,3).
ssq(4,5). ssq(4,6). ssq(5,6).
ssq(7,8). ssq(7,9). ssq(8,9).
ssq(B, A) :- num(A), num(B), ssq(A, B).

% sudoku rules:
% in the same row must not be the same number twice
:- num(R), num(C1), num(C2), num(X), p(R, C1, X), p(R, C2, X), C1 != C2.
% in the same column must not be the same number twice
:- num(C), num(R1), num(R2), num(X), p(R1, C, X), p(R2, C, X), R1 != R2.
% in the same square must not be the same number twice
:- num(C1), num(R1), num(C2), num(R2), ssq(C1, C2), ssq(R1, R2), num(X), num(Y), 
		p(R1, C1, X), p(R2, C2, X), R1 + 10 * C1 != R2 + 10 * C2.
% only one number per position
1{p(R,C,1),p(R,C,2),p(R,C,3),p(R,C,4),p(R,C,5),p(R,C,6),p(R,C,7),p(R,C,8),p(R,C,9)}1
	:- num(R), num(C).