(define (problem process-datachunka)
    (:domain data-network)

    (:objects
        ; Server
        server1 server2 - server

        ; Dati
        ; datachunka: Il dato reale da processare
        ; nil-data: Un dato vuoto necessario perché l'azione 'process' richiede 2 input
        ; processed-data: Il risultato finale
        datachunka nil-data processed-data - data

        ; Script di elaborazione
        process-script - script

        ; Numeri per gestire dimensioni e capacità
        n0 n500 n1000 - numbers
    )

    (:init
        ; --- Aritmetica e Logica Numerica ---
        ; Definiamo le somme necessarie per il calcolo della RAM
        (SUM n0 n0 n0)          ; 0 + 0 = 0
        (SUM n0 n500 n500)      ; 0 + 500 = 500 (Caricamento/Invio)
        (SUM n500 n0 n500)      ; 500 + 0 = 500 (Per l'input nullo)
        (SUM n500 n500 n1000)   ; 500 + 500 = 1000 (Processamento: 500 input + 500 output)

        ; Confronti per i limiti di capacità
        (LESS-EQUAL n0 n1000)
        (LESS-EQUAL n500 n1000)
        (LESS-EQUAL n1000 n1000)

        ; --- Configurazione Server ---
        ; Server 1 (Storage)
        (CAPACITY server1 n1000)
        (usage server1 n0)      ; RAM vuota all'inizio

        ; Server 2 (Compute)
        (CAPACITY server2 n1000)
        (usage server2 n0)      ; RAM vuota all'inizio

        ; Connessione di rete
        (CONNECTED server1 server2)

        ; --- Configurazione Dati ---
        ; Dimensioni
        (DATA-SIZE datachunka n500)
        (DATA-SIZE processed-data n500) ; Assumiamo che l'output pesi quanto l'input
        (DATA-SIZE nil-data n0)         ; Dato fittizio dimensione 0

        ; Posizioni Iniziali
        (saved datachunka server1)      ; Il dato grezzo è su disco su Server1
        
        ; Per facilitare il processo, assumiamo che il dato vuoto sia già disponibile su Server2
        (cached nil-data server2)       

        ; --- Definizione dello Script ---
        ; Lo script prende datachunka e nil-data per produrre processed-data
        (SCRIPT-IO process-script datachunka nil-data processed-data)

        ; --- Costi (Inizializzazione funzioni numeriche) ---
        (= (total-cost) 0)
        
        ; Definiamo costi arbitrari per le azioni (richiesto dalle funzioni nel dominio)
        (= (io-cost server1 n500) 10)
        (= (io-cost server2 n500) 10)
        (= (send-cost server1 server2 n500) 20)
        (= (process-cost process-script server2) 50)
        ; Costi per operazioni a dimensione 0 (per evitare errori)
        (= (io-cost server2 n0) 0)
        (= (send-cost server1 server2 n0) 0)
    )

    (:goal
        (and
            ; L'obiettivo è che il dato processato sia nella cache (RAM) del Server 2
            ; (come risultato dell'azione 'process')
            (cached processed-data server2)
        )
    )

    (:metric minimize (total-cost))
)