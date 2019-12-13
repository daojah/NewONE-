#! /bin/bash -x
OPERATOR="O"
#EMAIL_PPB=""
EMAIL_SUPPORT="@com"

LOG_PATH="/var/log/biab/reports/"
CURRENT_DATE="$(date +%Y-%m-%d)"
MESSAGE=", please kindly check the attached weekly DB reports *.csv files for ${CURRENT_DATE} - ${OPERATOR}"
CSV_FILES="$(ls ${LOG_PATH} | grep -E "(FX_RATE_MARGIN_1_${CURRENT_DATE}|PRODUCT_PERFORMANCE_1_${CURRENT_DATE}|REVENUE_1_${CURRENT_DATE}).csv")"
ATTACHMENT="$(for i in ${CSV_FILES}; do echo "-a $i "; done)"

## send message to addresses
if [[ -n "${CSV_FILES}" ]] ; then
    #echo $MESSAGE | mail -v -s "[${OPERATOR}] Weekly DB report files from $(hostname) for ${CURRENT_DATE}" ${ATTACHMENT} ${EMAIL_PPB}
    echo $MESSAGE | mail -v -s "[${OPERATOR}] Weekly DB report files from $(hostname) for ${CURRENT_DATE}" ${ATTACHMENT} $EMAIL_SUPPORT

fi

exit 0
