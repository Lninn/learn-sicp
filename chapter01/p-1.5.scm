; p32
; 根据过程 p 和 test 的定义

; 如果解释器采用正则序求值
; 在过程模型的替换中，我们应该首先用运算对象表达式去代换形式参数，
; 直到得到一个只包含基本运算符的表达式，然后再去进行求值
; 当执行 (test 0 (p)) 时，会依次执行 if 表达式中的 predicate con alter 各部分表达式
; 因为 (= x 0) 为 true，所以 if 表达式的值为 0，其余部分的代码并不会执行


; 如果解释器采用应用序求值
; 在过程模型替换中，应该首先计算中实际参数表达式的值，然后再去代换过程中的形式参数
; 当执行 (test 0 (p)) 时，计算 参数表达式 (p) 会进行到一个无限的递归调用中，
; 所以程序最终会出现调用栈异常而退出的情况