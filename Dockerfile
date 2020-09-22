FROM blazemeter/taurus

ADD test.jmx /tmp/test.jmx

RUN touch /tmp/test.jmx ; bzt -o modules.jmeter.path=/jmeter /tmp/test.jmx -o modules.jmeter.plugins=[$(curl https://jmeter-plugins.org/repo/ | python -c 'import json; import sys; sys.stdout.write(",".join([x["id"] for x in json.loads(sys.stdin.read()) if "id" in x.keys()]))')] || true
RUN ls /jmeter/lib/ext/jmeter-plugins-casutg-*.jar ; rm -rf /tmp/* ; chmod -R 777 / || true

ENV PATH=$PATH:/jmeter/bin/

ENTRYPOINT []
