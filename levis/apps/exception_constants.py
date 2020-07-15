# Status types
STATUS_TYPE = {
    "APP": "App",
    "EMAIL": "Email",
}
# Exception fields
EXCEPTION_TYPE_NON_RETRYABLE = "NonRetryable"
EXCEPTION_TYPE_RETRYABLE = "Retryable"

# Non retryable exception codes
NONRETRYABLE_CODE = {
    "BAD_REQUEST": "BadRequest",  # Generic exception which can be used for bad request
    "GENERIC_FAILURE": "GenericFailure",  # HDFC Customer portal API failed
}

RETRYABLE_CODE = {
    "API_UNREACHABLE": "ApiUnreachable",  # any generic tpt API is unreachable for moment
    "EMAIL_FAILURE": "EmailApiFailure"
}