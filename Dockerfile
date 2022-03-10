FROM ubuntu:20.04 as builder

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y clang

ADD qoifuzz.c qoi.h /
RUN clang -fsanitize=address,fuzzer qoifuzz.c -o qoifuzz

FROM ubuntu:20.04

COPY --from=builder /qoifuzz /
