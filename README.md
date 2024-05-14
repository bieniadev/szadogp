# sigma
zrobić style
## szukac w kodzie // to do:
oznaczaja one elementy do zrobienia

## ZNANE BUGI TO FIX
GDZIE: LobbyScreen>grupy
BUG: tablica z id userow zawiera id tego samego usera w grupie jednej i drugiej 
REPRODUKCJA: _wymaga conajmniej 3 graczy_ Przydziel po kolei grupy 1>2>3, nastepnie zmien grupe pierwszego na WYZSZA 2>2>3, nastepnie zmien grupe drugiego na NIZSZA 2>1>3; (zamiana grup między userami, działą w dwie strony) efekt: grupa z nr 2 ma tablice z dwoma userami
OBEJSCIE: wygrac ponownie tą samą grupę dla pierwszego gracza z zamiany
