;; TODO
; (fn _G.dump [o]
;   (if (= (type o) :table) (do
;                             (var s "{ ")
;                             (each [k v (pairs o)]
;                               (when (not= (type k) :number)
;                                 (set-forcibly! k (.. "\"" k "\"")))
;                               (set s (.. s "[" k "] = " (dump v) ",")))
;                             (.. s "} ")) (tostring o)))
;
