FROM microblink/base:1.0
LABEL maintainer="Matija Stepanic <matija.stepanic@microblink.com>" version="1.0"

EXPOSE 8080

VOLUME /tmp

ENV DEFAULT_NUMBER_OF_WORKERS=2
ENV TASK_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED=200
ENV MINUTES_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED=120
ENV PING_IS_ENABLED=true
ENV PING_PERIOD_TASKS=100

ADD bin/blinkid-core/lib/Linux/x64 wrapper/lib
ADD bin/blinkid-core/resources wrapper/resources

ADD target/api.jar app.jar
ADD bin/Linux/x64/BlinkIDNativeWrapper wrapper/BlinkIDNativeWrapper

CMD java $JAVA_OPTS -Dmicroblink.ping.period.tasks=$PING_PERIOD_TASKS -Dmicroblink.ping.isEnabled=$PING_IS_ENABLED -Dmicroblink.licensee="$LICENSEE" -Dmicroblink.licenceKey="$LICENCE_KEY" -DblinkId.wrapperPath="/wrapper/BlinkIDNativeWrapper /wrapper/resources $LICENSEE $LICENCE_KEY" -DblinkId.defaultNumberOfWorkers=$DEFAULT_NUMBER_OF_WORKERS -DblinkId.taskCounterLimitWhenWorkerShouldBeStopped=$TASK_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED -DblinkId.minutesCounterLimitWhenWorkerShouldBeStopped=$MINUTES_COUNTER_LIMIT_WHEN_WORKER_SHOULD_BE_STOPPED -Djava.security.egd=file:/dev/./urandom -jar /app.jar