side(left). side(right).
time(1..8).
thing(goat). thing(dog). thing(cabbage).


% All things start left
pos(1, left, farmer).
pos(1, left, goat).
pos(1, left, dog).
pos(1, left, cabbage).

% Goal: All things end up right
done(T) :- time(T), pos(T, right, farmer), pos(T, right, goat),
      pos(T, right, cabbage), pos(T, right, dog).
done(T) :- time(T), time(U), T = U + 1, done(U).
:- not done(8).

% Farmer always goes left -> right -> left -> right -> ... if not done yet
pos(T, right, farmer) :-
      time(T), time(U), T = U + 1, pos(U, left, farmer), not done(U).
pos(T, left, farmer) :-
      time(T), time(U), T = U + 1, pos(U, right, farmer), not done(U).

% The farmer can only carry one other thing to the other side
0{ carry(T, goat), carry(T, cabbage), carry(T, dog) }1 :- time(T), not done(T).

% The farmer can't carry things which are at the opposite side
:- thing(X), time(T), carry(T, X), side(S), side(S2), S != S2,
      pos(T, S, farmer), pos(T, S2, X).

% Farmer carries a thing to the other side
pos(T, S, X) :- time(T), time(U), T = U + 1, side(S), side(S2), S != S2,
      thing(X), pos(U, S2, X), carry(U, X), not done(U).

% Things that are not carried at a timepoint U stay at the same side
pos(T, S, X) :- time(T), time(U), side(S), thing(X), T = U + 1, pos(U, S, X),
      not carry(U, X), not done(U).


% The farmer cannot leave the goat & the dog alone
:- time(T), side(S), side(S2), S != S2, pos(T, S, goat), pos(T, S, dog),
      pos(T, S2, farmer).
% The farmer cannot leave the goat & the cabbage alone
:- time(T), side(S), side(S2), S != S2, pos(T, S, goat), pos(T, S, cabbage),
      pos(T, S2, farmer).
