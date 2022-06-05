(in-package :yason)

(define-condition json-parse-error (parse-error)
  ((message :initarg :message
            :reader message))
  (:report (lambda (c stream)
             (format stream "JSON parse failure: ~a"
                     (message c)))))

(define-condition wrapped-parse-error (json-parse-error)
  ((wrapped-condition :initarg :condition
                      :reader wrapped-condition))
  (:report (lambda (c stream)
             (format stream "Error during parse: ~a"
                     (wrapped-condition c)))))

(define-condition cannot-convert-key (json-parse-error)
  ((key-string :initarg :key-string
               :reader key-string))
  (:report (lambda (c stream)
             (format stream "cannot convert key ~S used in JSON object to hash table key"
                     (key-string c)))))

(define-condition duplicate-key (json-parse-error)
  ((key-string :initarg :key-string
               :reader key-string))
  (:report (lambda (c stream)
             (format stream "Duplicate dict key ~S"
                     (key-string c)))))

(define-condition invalid-constant (json-parse-error)
  ()
  (:report (lambda (c stream)
             (declare (ignore c))
             (format stream "Invalid constant"))))

(define-condition expected-colon (json-parse-error)
  ((key-string :initarg :key-string
               :reader key-string))
  (:report (lambda (c stream)
             (format stream "expected colon to follow key ~S used in JSON object"
                     (key-string c)))))
