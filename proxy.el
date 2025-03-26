;; Proxy setting
(cond ((getenv "HTTP_PROXY")
       (let* ((url_ (url-generic-parse-url (getenv "HTTP_PROXY")))
              (auth_ (if (and (url-user url_) (url-password url_) )
                         (base64-encode-string
                          (format "%s:%s" (url-user url_) (url-password url_)))
                       nil))
              (host_ (format "%s:%s" (url-host url_) (url-portspec url_))))

         (defvar url-proxy-services
               (list (cons "no_proxy"  "^\\(localhost\\|10.*\\)")
                     (cons "http" host_)))
         (if auth_
             (defvar url-http-proxy-basic-auth-storage
               (list (list host_ (cons "Proxy" auth_)))))
         )))

