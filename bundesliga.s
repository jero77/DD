round(29..34).
p(29..68). %% maximally 68P can be reached by the current leader

% teams
team(d). team(n). team(ki). team(r). team(in). team(bo).
team(bi). team(au). team(svs). team(du). team(un). team(bs).
team(dd). team(sp). team(ft). team(hdh). team(da). team(kl).

% standings after 29 rounds:
points(29,d,53).
points(29,n,50).
points(29,ki,46).
points(29,r,41).
points(29,in,41).
points(29,bo,40).
points(29,bi,40).
points(29,au,39).
points(29,svs,38).
points(29,du,38).
points(29,un,37).
points(29,bs,37).
points(29,dd,37).
points(29,sp,37).
points(29,ft,37).
points(29,hdh,34).
points(29,da,32).
points(29,kl,29).

% games of the remaining rounds:
game(30,in,n). game(30,hdh,d). game(30,dd,ki).
game(30,du,svs). game(30,ft,r). game(30,sp,un).
game(30,bi,au). game(30,da,bs). game(30,bo,kl).

game(31,ki,n). game(31,d,in). game(31,au,du).
game(31,r,sp). game(31,svs,da). game(31,un,hdh).
game(31,bs,bi). game(31,kl,dd). game(31,ft,bo).

game(32,n,bs). game(32,dd,d). game(32,in,ki).
game(32,du,r). game(32,hdh,svs). game(32,da,un).
game(32,bi,kl). game(32,sp,ft). game(32,bo,au).

game(33,svs,n). game(33,d,ki). game(33,ft,du).
game(33,r,da). game(33,un,bo). game(33,sp,bi).
game(33,bs,in). game(33,kl,hdh). game(33,au,dd).

game(34,n,d). game(34,ki,bs). game(34,du,sp).
game(34,bo,r). game(34,dd,un). game(34,bi,svs).
game(34,in,kl). game(34,hdh,ft). game(34,da,au).


% game can be won/lost/drawn, consider home team & deduct for other team
% D = Day, H = Home, O = other
1{win(D, H), loose(D, H), draw(D, H)}1:- team(H),round(D),team(O),game(D, H, O).
loose(D, O) :-  team(H), team(O), round(D), win(D, H), game(D, H, O).
win(D, O) :- team(H), team(O), round(D), loose(D, H), game(D, H, O).
draw(D, O) :- team(H), team(O), round(D), draw(D, H), game(D, H, O).

% win -> +3pts, loose -> +0 pts, draw -> +1pts
points(D, T, P) :- round(D), round(L), p(P), p(X), team(T), D = L + 1,
    points(L, T, X), win(D, T), P = X + 3.
points(D, T, P) :- round(D), round(L), p(P), team(T), D = L + 1,
    points(L, T, P), loose(D, T).
points(D, T, P) :- round(D), round(L), p(P), p(X), team(T), D = L + 1,
    points(L, T, X), draw(D, T), P = X + 1.

% deny solutions where after 34 rounds 4th to 18thhave not all 44 Pts
% F = 1st Place, S = 2nd Place, T = 3rd Place,
%:- team(F),team(S),team(T),p(FP),p(SP),p(TP), F != S, S != T, F != T,
%    points(34, F, FP), points(34, S, SP), points(34, T, TP), FP >= SP, SP >= TP,
%    team(X), X != F, X != S, X != T, p(XP), points(34, X, XP), XP != 44, TP >= XP.

%:- p(PD), p(PN), p(PKI), points(34,d,PD), points(34,n,PN), points(34,ki,PKI),
%   team(X), X != d, X != n, X != ki, p(XP), points(34, X, XP), XP != 44.

:- team(X), X != d, X != n, X != ki, p(XP), points(34, X, XP), XP != 44.
