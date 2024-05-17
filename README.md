# Sigma?

S.Z.A.DO GP -> Rozszyfrować hasło

## szukac w kodzie // to do:

oznaczaja one elementy do zrobienia

## ZNANE BUGI TO FIX


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
--
GDZIE: HomeScreen> isLoading
BUG: isLoading załącza dwie animacje na komponetach
REPRODUKCJA: kliknąc w swój profil/guzik stworzenia gry
OBEJSCIE: brak
