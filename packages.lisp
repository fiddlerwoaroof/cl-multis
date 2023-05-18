(defpackage :fwoar.cl-multis.packages
  (:use :cl )
  (:export ))
(in-package :fwoar.cl-multis.packages)

(defpackage :fwoar.cl-multis.mop
  (:use :cl )
  (:export #:isa?-using-hierarchy
           #:derive-using-hierarchy
           #:underive-using-hierarchy
           #:parents-using-hierarchy
           #:hierarchy
           #:make-default-hierarchy))

(defpackage :fwoar.cl-multis.interface
  (:use :cl )
  (:export
   #:make-hierarchy
   #:derive
   #:isa?
   #:*default-hierarchy*
   #:reset
   #:get-multi-lambda
   #:alist->hierarchy
   #:parents
   #:ancestors
   #:underive))
