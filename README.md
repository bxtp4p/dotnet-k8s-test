# APM Dotnet Kubernetes Example

An example for a customer on how to use Splunk APM on a .NET application running in Kubernetes.

The `Dockerfile` in this repo is used to load the `signalfx-dotnet-tracing` library files to their default directory (`/opt/signalf-dotnet-tracing`).

Then, it's used as an initContainer in the `example.yaml` manifest so that the files are then available via a volumeMount in the application container.

Then all that's left is to set the appropriate environment variables for the tracer (see: https://github.com/signalfx/signalfx-dotnet-tracing#configure-the-signalfx-tracing-library-for-net). 

Note, I've enabled debugging on the tracer for this example so that you can see if it's working or not. You should see entries like this in your application container's logs:

```
[DBG] Span started: [s_id: 14938313515406949587, p_id: null, t_id: 1b3b0564434bc315b72ecc905a51a008]

[DBG] Span closed: [s_id: 14938313515406949587, p_id: null, t_id: 1b3b0564434bc315b72ecc905a51a008] for (Service: TestASPNetCoreService, Resource: /, Operation: /, Tags: [environment,signalfx.tracing.library,signalfx.tracing.version,component,span.kind,http.method,http.request.headers.host,http.url,http.status_code])
```

Also note that in my setup (how I've tested this), the spans are being sent to an OTEL collector running in my Kubernetes cluster.

Lastly, the application can be reached by:

```
$ kubectl port-forward service/dotnettestservice 8080:8080
```

Then open up http://localhost:8080 in your browser to send some traffic to the app.