FROM blazemeter/taurus

ADD test.jmx /tmp/test.jmx
RUN apt-get update && apt-get install python
RUN curl https://jmeter-plugins.org/repo/ | python -c 'import json; import sys; sys.stdout.write(",".join([x["id"] for x in json.loads(sys.stdin.read()) if "id" in x.keys() and not x["id"].startswith("ulp")]))' > plugins.lst \
    cat plugins.lst
RUN bzt -o modules.jmeter.path=/jmeter /tmp/test.jmx -o modules.jmeter.plugins=[$(cat plugins.lst)] || true
RUN ls /jmeter/lib/ext/jmeter-plugins-casutg-*.jar \
    rm -rf /tmp/*
RUN chmod -R 777 / || true

ENV PATH=$PATH:/jmeter/bin/

ENTRYPOINT []
