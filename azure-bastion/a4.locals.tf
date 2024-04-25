locals {
    owners = var.business_division
    environment = var.environment
    resource_name_prefix = "${var.business_division}-${var.environment}"

    common_tags = {
        owners = local.owners
        environment = local.environment

    }
}

#when the sequence not working what you will do.. depends_on
#azure outpost