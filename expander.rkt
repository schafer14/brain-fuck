#lang br/quicklang

(define-macro (bf-module-begin PARSE-TREE)
              #'(#%module-begin
                 PARSE-TREE))

(provide (rename-out [bf-module-begin #%module-begin]))

(define-macro (bf-program OP-OR-LOOP-ARG ...)
              #'(void OP-OR-LOOP-ARG ...))

(provide bf-program)

(define-macro (bf-loop "[" OP-OR-LOOP-ARG ... "]")
              #'(until (zero? (current-byte))
                       OP-OR-LOOP-ARG ...))

(provide bf-loop)

(define-macro-cases bf-op
                    [(bf-op ">") #'(next)]
                    [(bf-op "<") #'(prev)]
                    [(bf-op "+") #'(inc)]
                    [(bf-op "-") #'(dec)]
                    [(bf-op ".") #'(egress)]
                    [(bf-op ",") #'(ingress)])

(provide bf-op)

(define arr (make-vector 30000 0))
(define ptr 0)

(define (current-byte) (vector-ref arr ptr))

(define (set-current-byte! val) (vector-set! arr ptr val))

(define (next) (set! ptr (+ ptr 1)))
(define (prev) (set! ptr (- ptr 1)))
(define (inc) (set-current-byte! (+ (current-byte) 1)))
(define (dec) (set-current-byte! (- (current-byte) 1)))
(define (egress) (write-byte (current-byte)))
(define (ingress) (set-current-byte! (read-byte)))




