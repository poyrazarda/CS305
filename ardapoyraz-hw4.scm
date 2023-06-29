(define main-procedure
    (lambda (tripleList)
        (if (or (null? tripleList) (not (list? tripleList)))
            (error "ERROR305: the input should be a list of full of triples")
            (if (check-triple? tripleList)
                (sort-area (filter-pythagorean (filter-triangle
                                        (sort-all-triples tripleList))))
                (error "ERROR305: the input should be a list full of triples")
            )
        )
    )
)

(define check-triple?
    (lambda (tripleList)
        (define proper?
            (lambda (triple)
                (and (list? triple)
                    (= (length triple) 3)
                    (number? (car triple))
                    (number? (cadr triple))
                    (number? (caddr triple))
                )
            )
        )
        (every proper? tripleList)
    )
)

(define check-length?
    (lambda (inTriple count)
        (= (length inTriple) count)
    )
)

(define check-sides?
    (lambda (inTriple)
        (every (lambda (s) (and (number? s) (> s 0) )) inTriple)
    )
)

(define sort-all-triples
    (lambda (tripleList)
        (map (lambda (triple) (sort triple <)) tripleList)
    )
)

(define sort-triple
    (lambda (inTriple)
        (sort inTriple <)
    )
)

(define filter-triangle
    (lambda (tripleList)
        (filter 
            (lambda (triple)
                (let 
                      ((s1 (car triple))
                      (s2 (cadr triple))
                      (s3 (caddr triple)))
                    (and 
                        (< 0 s1)
                        (< 0 s2)  
                        (< 0 s3)
                        (< s1 (+ s2 s3))
                        (< s2 (+ s1 s3))
                        (< s3 (+ s1 s2))
                    ) 
                )
            )
        tripleList
        )
    )
)

(define triangle?
    (lambda (triple)
        (let 
              ((s1 (car triple))
              (s2 (cadr triple))
              (s3 (caddr triple)))
            (and 
                (< 0 s1)
                (< 0 s2)  
                (< 0 s3)
                (< s1 (+ s2 s3))
                (< s2 (+ s1 s3))
                (< s3 (+ s1 s2))
            ) 
        )
    )
)

(define filter-pythagorean
    (lambda (tripleList)
        (filter (lambda (triple)
           (let 
                 ((s1 (car triple))
                 (s2 (cadr triple))
                 (s3 (caddr triple)))
             (= (+ (* s1 s1) (* s2 s2)) (* s3 s3))
            )
           )
        tripleList
        )
    )
)

(define pythagorean-triangle?
    (lambda (triple)
        (let 
              ((s1 (car triple))
              (s2 (cadr triple))
              (s3 (caddr triple)))
            (= (+ (* s1 s1) (* s2 s2)) (* s3 s3))
        )
    )
)


(define sort-area
    (lambda (tripleList)
        (sort tripleList
            (lambda (triple_1 triple_2)
                (let 
                      ((first (* 0.5 (car triple_1) (cadr triple_1)))
                      (second (* 0.5 (car triple_2) (cadr triple_2))))
                  (< first second)
                )
            )
        )
    )
)

(define get-area
    (lambda (triple)
        (let ((bl (car triple))
              (h (cadr triple)))
            (* 0.5 bl h)
        )
    )
)
