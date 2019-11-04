FROM golang:latest AS builder

RUN go get -u github.com/uber/makisu/bin/makisu && makisu version

FROM alpine

LABEL maintainer="Mazunin Konstantin <mazuninky@gmail.com>"

RUN apk add --no-cache python; \
#############
## AWS CLI ##
#############
    wget --output-document="awscli-bundle.zip" "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip"; \
	unzip awscli-bundle.zip; \
	./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws; \
	rm awscli-bundle.zip && rm -rf awscli-bundle; \
    aws --version;

#############
## Makisu  ##
#############
COPY --from=builder /go/bin /usr/local/bin