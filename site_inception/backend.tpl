region         = "${region}"
profile        = "${profile}"
key            = "${environment}-${site}.tfstate"
bucket         = "${organization}-${environment}-site-${site}-tfstate"
dynamodb_table = "${organization}_${environment}_site_${site}_tfstatelock"
encrypt        = true
