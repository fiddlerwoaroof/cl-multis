(in-package :fwoar.cl-multis.interface)

(defvar *default-hierarchy*
  (fwoar.cl-multis.mop:make-default-hierarchy))

(defun reset ()
  (setf *default-hierarchy*
        (fwoar.cl-multis.mop:make-default-hierarchy)))

(defun isa? (child parent &key (h *default-hierarchy*))
  (fwoar.cl-multis.mop:isa?-using-hierarchy h child parent))

(defun derive (child parent &key (h *default-hierarchy*))
  (fwoar.cl-multis.mop:derive-using-hierarchy
   h child parent))

(defun underive (child &key (h *default-hierarchy*))
  (fwoar.cl-multis.mop:underive-using-hierarchy h child))

(defun parents (child &key (h *default-hierarchy*))
  (fwoar.cl-multis.mop:parents-using-hierarchy h child))
(defun ancestors (child &key (h *default-hierarchy*))
  (loop for cur = child then (parents cur :h h)
        while cur
        collect cur))

(defun make-hierarchy ()
  (fwoar.cl-multis.mop:make-default-hierarchy))

(defun alist->hierarchy (alist &key (h *default-hierarchy*))
  (mapc (lambda (it)
          (destructuring-bind (parent . child) it
            (mapcar (lambda (child)
                      (derive child parent :h h))
                    child)))
        alist))

(defun get-multi-lambda (dispatch-fn
                         &rest methods
                         &key &allow-other-keys)
  (let* ((dispatch (alexandria:plist-hash-table methods))
         (types (alexandria:hash-table-keys dispatch)))
    (lambda (&rest args)
      (let* ((dispatch-value (apply dispatch-fn args))
             (applicable-methods
               (remove-if-not (lambda (type)
                                (isa? dispatch-value type))
                              types)))
        (if (null (cdr applicable-methods))
            (apply (gethash (car applicable-methods)
                            dispatch)
                   args)
            (error "ambiguous"))))))
