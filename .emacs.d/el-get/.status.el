((el-get status "installed" recipe
		 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "master" :pkgname "dimitri/el-get" :info "." :compile
				("el-get.*\\.el$" "methods/")
				:features el-get :post-init
				(when
					(memq 'el-get
						  (bound-and-true-p package-activated-list))
				  (message "Deleting melpa bootstrap el-get")
				  (unless package--initialized
					(package-initialize t))
				  (when
					  (package-installed-p 'el-get)
					(let
						((feats
						  (delete-dups
						   (el-get-package-features
							(el-get-elpa-package-directory 'el-get)))))
					  (el-get-elpa-delete-package 'el-get)
					  (dolist
						  (feat feats)
						(unload-feature feat t))))
				  (require 'el-get))))
 (highlight-parentheses status "installed" recipe
						(:name highlight-parentheses :description "Highlight the matching parentheses surrounding point." :type github :pkgname "nschum/highlight-parentheses.el"))
 (rect-mark status "installed" recipe
			(:name rect-mark :description "Mark a rectangle of text with highlighting." :type emacswiki))
 (undo-tree status "installed" recipe
			(:name undo-tree :description "Treat undo history as a tree" :website "http://www.dr-qubit.org/emacs.php" :type git :url "http://www.dr-qubit.org/git/undo-tree.git/")))
