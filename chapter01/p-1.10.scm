; Ackermann 函数
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))

; (A 1 5)
; ↓↓
; (A 0 (A 1 4))
; ↓↓
; (A 0 (A 0 (A 1 3)))
; ↓↓ 
; (A 0 (A 0 (A 0 (A 1 2))))
; ↓↓ 
; (A 0 (A 0 (A 0 (A 0 (A 1 1))))) 这里共 5 个 2 相乘

; 其中 (A x 1) = 2, (A 0 x) = 2 * x
; 所以 (A 1 5) 其实计算的是 2 的 5 次方的值，32
; 从而 (A 1 10) = 2 的 10 次方 1024

; (A 2 4)
; ↓↓
; (A 1 (A 2 3))
; ↓↓
; (A 1 (A 1 (A 2 2)))
; ↓↓
; (A 1 (A 1 (A 1 (A 2 1))))
;
; 其中 (A x 1) = 2, (A 1 x) = x 的平方
; 所以 (A 2 4) = 2 的平方的平方的平方 65536 即 2 的 16 次方
; 从而 (A 2 4) 计算的是 2 的 4 - 1 次连续平方


; (A 3 3)
; ↓↓
; (A 2 (A 3 2))
; ↓↓
; (A 2 (A 2 (A 3 1)))
; 
; 其中 (A x 1) = 2, 所以上面的推算可以归纳为
; (A 2 (A 2 2)), 其中 (A 2 2) = 4
; 即
; 最终计算的是 (A 2 4) 为 65536

; 计算 n 的 2 倍
(define (f n) (A 0 n))

; 计算 2 的 n 次方
(define (g n) (A 1 n))

;计算递归的 2 的 n 次方
(define (h n) (A 2 n))

; 计算 5 乘以 n 的平方
(define (k n) (* 5 n n))
