(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))


(define (variable? exp)
  (symbol? exp))


(define (quoted? exp)
	(tagged-list? exp 'quote))

(define (text-of-quotation exp)
	(cadr exp))


(define (assignment? exp)
	(tagged-list? exp 'set!))

(define (assignment-variable exp)
	(cadr exp))

(define (assignment-value exp)
	(caddr exp))


(define (definition? exp)
	(tagged-list? exp 'define))

(define (definition-variable exp)
	(if (symbol? (cadr exp))
		(cadr exp)
		(caadr exp)))

(define (definition-value exp)
	(if (symbol? (cadr exp))
		(caddr exp)
		(make-lambda (cdadr exp)
								 (cddr exp))))
								 

(define (lambda? exp)
	(tagged-list? exp 'lambda))

(define (lambda-parameters exp)
	(cadr exp))

(define (lambda-body exp)
	(cddr exp))

(define (make-lambda parameters body)
	(cons 'lambda (cons parameters body)))


(define (if? exp)
	(tagged-list? exp 'if))

(define (if-predicate exp)
	(cadr exp))

(define (if-consequent exp)
	(caddr exp))

(define (if-alternative exp)
	(if (not (null? (cdddr exp)))
		(cadddr exp)
		'false))

(define (make-if predicate consequent alternative)
	(list 'if predicate consequent alternative))


(define (begin? exp)
	(tagged-list? exp 'begin))

(define (begin-actions exp)
	(cdr exp))

(define (last-exp? exp)
	(null? (cdr exp)))

(define (first-exp exp)
  (car exp))

(define (rest-exps exp)
	(cdr exp))

(define (sequence->exp seq)
	(cond ((null? seq) seq)
				((last-exp? exp) (first-exp exp))
				(else (make-begin seq))))

(define (make-begin seq)
	(cons 'begin seq))


(define (application? exp)
	(pair? exp))

(define (operator exp)
  (car exp))

(define (operands exp)
  (cdr exp))

(define (no-operands? ops)
  (null? ops))

(define (first-operand ops)
  (car ops))

(define (rest-operands ops)
  (cdr ops))


(define (cond? exp)
  (tagged-list? exp 'cond))

(define (cond-clauses exp)
  (cdr exp))

(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))

(define (cond-predicate clause)
  (car clause))

(define (cond-actions clause)
  (cdr clause))

(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
  (if (null? clauses)
      'false
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause ins't last -- COND->IF" clauses))
            (make-if (cond-predicate first)
                     (sequence->exp (cond-actions first))
                     (expand-clauses rest))))))