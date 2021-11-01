# this file is managed by ansible
require ["vnd.dovecot.pipe", "copy", "imapsieve", "environment", "imap4flags"];

if environment :is "imap.cause" "COPY" {
    # pipe :copy "sa-learn-spam.sh";
    pipe :copy "rspamc" ["learn_spam"];
}

# Catch replied or forwarded spam
elsif anyof (allof (hasflag "\\Answered",
                    environment :contains "imap.changedflags" "\\Answered"),
             allof (hasflag "$Forwarded",
                    environment :contains "imap.changedflags" "$Forwarded")) {
    pipe :copy "rspamc" ["learn_spam"];
    # pipe :copy "sa-learn-spam.sh";
}
