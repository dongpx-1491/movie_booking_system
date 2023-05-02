# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/vendorjs", under: "vendorjs"

pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.1.3/dist/js/bootstrap.esm.js"
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.2/lib/index.js"
pin "jquery_rails", to: "jquery.min.js", preload: true
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.6.4/dist/jquery.js"
pin "jquery_ujs", to: "jquery_ujs.js", preload: true
pin "popper", to: "popper.js", preload: true
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "mixitup" # @3.3.1
pin "owl.carousel", to: "owl.carousel.min.js", preload: true
pin "slicknav" , to: "jquery.slicknav.js", preload: true
pin "nice-select", to: "jquery.nice-select.min.js", preload: true
pin "player", to: "player.js", preload: true
pin "mixi", to: "mixitup.min.js", preload: true
pin "window-load", to: "window_load.js"
pin "custom", to: "custom.js", preload: true
pin "admin", to: "admin.js", preload: true
pin "main-layout", to: "main_layout.js", preload: true
pin "@fortawesome/fontawesome-free", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.4.0/js/all.js", preload: true
pin "toastr", to: "https://ga.jspm.io/npm:toastr@2.1.4/toastr.js"
pin "select2", to: "https://ga.jspm.io/npm:select2@4.1.0-rc.0/dist/js/select2.js"
