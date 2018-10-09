FROM microblink/base:1.0
LABEL maintainer="Matija Stepanic <matija.stepanic@microblink.com>" version="1.0"

EXPOSE 8080

VOLUME /tmp

ENV DEFAULT_NUMBER_OF_WORKERS=2
ENV TASK_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED=200
ENV MINUTES_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED=120

ENV PING_IS_ENABLED=true
ENV PING_PERIOD_TASKS=100

ENV MLS_IS_ENABLED=false

ENV MICROBLINK_IDENTITY_IS_ENABLED=false
ENV MICROBLINK_IDENTITY_SERVER_URL=https://api.microblink.com/id
ENV MICROBLINK_IDENTITY_CONSUMER_AUTHENTICATION_HEADER=""

ENV MICROBLINK_IDENTITY_CONSUME_BATCH_WHEN_ACCUMULATED_EXECUTIONS_ARE_MORE_THAN=100
ENV MICROBLINK_IDENTITY_CONSUME_BATCH_WHEN_HOW_MANY_SECONDS_SINCE_LAST_CONSUMING=60

ENV MICROBLINK_IDENTITY_IS_ENABLED_AND_AUTHORIZATION_IS_MISSING_IS_MASKING_RESULTS_ENABLED=false
ENV MAX_VISIBLE_MASKED_CHARACTERS_PER_PROPERTY=10
ENV MAX_VISIBLE_MASKED_PERCENTAGE_OF_PROPERTY=0.4

# ENV LICENCE_KEY is deprecated and it will be removed in next major release, use LICENSE_KEY instead
ENV LICENCE_KEY=""
ENV LICENSE_KEY=""

ADD microblink-core-protobuf-wrapper/wrapper/binary/linux/x64/wrapper wrapper/wrapper
ADD microblink-core-protobuf-wrapper/wrapper/resources wrapper/resources

ADD target/api.jar app.jar

CMD java $JAVA_OPTS -Dmicroblink.licensee="$LICENSEE" -Dmicroblink.licenseKey="$LICENSE_KEY$LICENCE_KEY" -Dmicroblink.ping.isEnabled=$PING_IS_ENABLED -Dmicroblink.ping.period.tasks=$PING_PERIOD_TASKS -Dmicroblink.isMlsUploadEnabled=$MLS_IS_ENABLED -Dmicroblink.id.enabled=$MICROBLINK_IDENTITY_IS_ENABLED -Dmicroblink.id.serverURL="$MICROBLINK_IDENTITY_SERVER_URL" -Dmicroblink.id.consumerAuthenticationHeader="$MICROBLINK_IDENTITY_CONSUMER_AUTHENTICATION_HEADER" -Dmicroblink.id.isEnabledAndAuthorizationIsMissing.isMaskingResultsEnabled=$MICROBLINK_IDENTITY_IS_ENABLED_AND_AUTHORIZATION_IS_MISSING_IS_MASKING_RESULTS_ENABLED -Dmicroblink.id.consumeBatch.whenAccumulatedExecutionsAreMoreThan=$MICROBLINK_IDENTITY_CONSUME_BATCH_WHEN_ACCUMULATED_EXECUTIONS_ARE_MORE_THAN -Dmicroblink.id.consumeBatch.afterHowManySecondsStartNewConsuming=$MICROBLINK_IDENTITY_CONSUME_BATCH_WHEN_HOW_MANY_SECONDS_SINCE_LAST_CONSUMING -Dmicroblink.maxVisibleMaskedCharactersPerProperty=$MAX_VISIBLE_MASKED_CHARACTERS_PER_PROPERTY -Dmicroblink.maxVisibleMaskedPercentageOfProperty=$MAX_VISIBLE_MASKED_PERCENTAGE_OF_PROPERTY -Dmicroblink.wrapperPath="/wrapper/wrapper" -Dmicroblink.resourcesPath="/wrapper/resources" -Dmicroblink.defaultNumberOfWorkers=$DEFAULT_NUMBER_OF_WORKERS -Dmicroblink.taskCounterLimitWhenWorkerShouldBeStopped=$TASK_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED -Dmicroblink.minutesCounterLimitWhenWorkerShouldBeStopped=$MINUTES_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED -Djava.security.egd=file:/dev/./urandom -jar /app.jar
