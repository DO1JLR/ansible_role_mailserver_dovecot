# this file is managed by ansible
require ["vnd.dovecot.pipe", "copy", "imapsieve", "environment", "variables"];

if environment :matches "imap.mailbox" "*" {
    set "mailbox" "${1}";
}

if string "${mailbox}" [ "Trash", "train_ham", "train_prob", "train_spam" ] {
    stop;
}

pipe :copy "rspamc" ["learn_ham"];

