(in-package :fwoar.cl-multis.mop)

(defgeneric isa?-using-hierarchy (hierarchy child parent)
  (:method-combination or))
(defgeneric derive-using-hierarchy (hierarchy child parent)
  (:method :around (h _ __)
    (declare (ignore _ __))
    (call-next-method)
    h))
(defgeneric underive-using-hierarchy (hierarchy child)
  (:method :around (h _)
    (declare (ignore _))
    (call-next-method)
    h))
(defgeneric parents-using-hierarchy (hierarchy child))

(defclass hierarchy ()
  ())

(defclass hierarchy-hash (hierarchy)
  ((%h :reader %h :initform (make-hash-table))))
(defmethod isa?-using-hierarchy or ((h hierarchy-hash) child (parent symbol))
  (or (eql child parent)
      (loop with relations = (%h h)
            for ancestor = (gethash child relations)
              then (gethash ancestor relations)
            while ancestor
            when (eql ancestor parent) do (return t))))
(defmethod derive-using-hierarchy ((h hierarchy-hash) child (parent symbol))
  (setf (gethash child (%h h)) parent))
(defmethod underive-using-hierarchy ((h hierarchy-hash) child)
  (remhash child (%h h)))
(defmethod parents-using-hierarchy ((h hierarchy-hash) child)
  (gethash child (%h h)))

(defclass hierarchy-clos (hierarchy)
  ())
(defmethod isa?-using-hierarchy or ((hierarchy hierarchy-clos) (child symbol) (parent symbol))
  (subtypep child parent))
(defmethod isa?-using-hierarchy or ((hierarchy hierarchy-clos) child (parent class))
  (typep child parent))
(defmethod isa?-using-hierarchy or ((hierarchy hierarchy-clos) (child class) (parent class))
  (subtypep child parent))

(defclass hierarchy-hash+clos (hierarchy-hash hierarchy-clos)
  ())

(defun make-default-hierarchy ()
  (make-instance 'hierarchy-hash+clos))
