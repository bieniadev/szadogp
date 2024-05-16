# Sigma?

S.Z.A.DO GP -> Rozszyfrować hasło

## szukac w kodzie // to do:

oznaczaja one elementy do zrobienia

## ZNANE BUGI TO FIX

--
#FIXED!
GDZIE: LobbyScreen>grupy
BUG: tablica z id userow zawiera id tego samego usera w grupie jednej i drugiej
REPRODUKCJA: _wymaga conajmniej 3 (przy 2 też występuje) graczy_ Przydziel po kolei grupy 1>2>3, nastepnie zmien grupe pierwszego na WYZSZA 2>2>3, nastepnie zmien grupe drugiego na NIZSZA 2>1>3; (zamiana grup między userami, działą w dwie strony) efekt: grupa z nr 2 ma tablice z dwoma userami
OBEJSCIE: wybrac ponownie tą samą grupę dla pierwszego gracza z zamiany
--
GDZIE: RunningScreen>numery grup przy nickach
BUG: numery nie wyswietlaja sie poprawnie, jest zmieniona kolejnosc (posortowana od najnizszej). Nie wplywa to na koncowy wynik
REPRODUKCJA: ustawienie np. grupy nr.2 dla pierwszego gracza i grupy nr.1 dla drugiego gracza
OBEJSCIE: wybierac grupy po kolei zgodnie z indexem uzytkownikow w tabeli
--
GDZIE: LobbyScreen>advanced_button_dart:83
BUG: sprawdzenie na dołączenie gracza nie ma sensu bo zwraca puste grupy (musi wysłać api request ze zwrotna informacja o grupach wybranych)
REPRODUKCJA: checkowanie gry jako nie admin
OBEJSCIE: brak (guzik wyłączony)
