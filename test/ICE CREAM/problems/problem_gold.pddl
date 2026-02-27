(define (problem basic-order)
    (:domain myDomain)

    (:objects
        order1 - object       ; L'ordine di gelato
        vanillaflavor - object ; L'ingrediente disponibile
        lab - object          ; Luogo di ritiro (non usato nelle azioni, ma definito)
        customerhome - object ; Luogo di consegna (non usato nelle azioni, ma definito)
    )

    (:init
        ; --- Stato Iniziale del Processo ---
        ; (assembly) non è vero (L'ordine è vuoto)
        ; (packaging) non è vero
        (not (delivered)) ; L'ordine non è stato consegnato

        ; --- Stato Iniziale degli Ingredienti ---
        ; L'ingrediente 'Vanilla Flavor' è disponibile.
        (vanilla vanillaflavor) 
        
        ; L'ordine è disponibile, ma è "vuoto" (deve essere preparato)
        (order order1)
        
        ; Altri ingredienti richiesti per l'assemblaggio (assunti come disponibili per permettere l'azione successiva)
        ; Nota: Ho bisogno che 'have-cone' sia vero per poter assumere un 'assembly' iniziale
        (cone order1) ; Assumiamo che ci sia un cono come contenitore di base.
        (have-cone)
        (have-order)
        
        ; --- Predicati necessari per innescare l'assemblaggio implicito ---
        (have-vanilla) ; Assunto che il robot abbia già raccolto il gusto vanilla
        
        ; Assumiamo che l'ordine sia già nello stato 'assemble' per poter iniziare il packaging, 
        ; dato che il dominio non ha un'azione specifica per l'assemblaggio finale (che dovrebbe
        ; dipendere da have-vanilla, have-cone, etc.).
        (assemble) 
    )

    (:goal
        (and
            (delivered) ; L'obiettivo è che l'Ordine1 sia stato consegnato
        )
    )
)