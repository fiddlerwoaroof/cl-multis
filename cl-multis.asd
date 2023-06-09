;;; -*- Mode:Lisp; Syntax:ANSI-Common-Lisp; Package: ASDF-USER -*-
(in-package :asdf-user)

(defsystem :cl-multis
  :description ""
  :author "Ed L <edward@elangley.org>"
  :license "MIT"
  :depends-on (:alexandria
               :uiop
               :closer-mop)
  :serial t
  :components ((:file "packages")
               (:file "mop")
               (:file "interface")))

(defsystem :cl-multis/test
  :depends-on (:5am))
