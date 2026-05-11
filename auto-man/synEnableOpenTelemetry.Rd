%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synEnableOpenTelemetry}
\alias{synEnableOpenTelemetry}
\docType{methods}
\title{
synEnableOpenTelemetry
}
\description{
Enables OpenTelemetry instrumentation for the Synapse client to collect telemetry data
about your application's performance and behavior. This data can provide insights into
latency, errors, and other performance metrics.

Note: This is a one-way operation - once enabled, OpenTelemetry cannot be disabled within
the same process. To disable it, you must restart your Python interpreter or application.

When enabled, this method automatically:
1. Sets up instrumentation for dependent libraries:
    - **Threading** (via `ThreadingInstrumentor`): Ensures proper context propagation
      across threads for maintaining trace continuity in multi-threaded applications
    - **HTTP libraries**:
        - `requests` (via `RequestsInstrumentor`): Captures all HTTP requests, including
          methods, URLs, status codes, and timing information
        - `httpx` (via `HTTPXClientInstrumentor`): Tracks both synchronous and
          asynchronous HTTP requests
        - `urllib` (via `URLLibInstrumentor`): Monitors lower-level HTTP operations
    - Each instrumented HTTP library includes custom hooks that extract Synapse entity
      IDs from URLs and add them as span attributes
2. Configures traces to collect spans across your application:
    - Spans automatically capture operation duration, status, and errors
    - Attributes like `synapse.transfer.direction` and `synapse.operation.category`
      are properly propagated to child spans
    - Trace data is exported via OTLP (OpenTelemetry Protocol)
3. Adds resource information to your traces, including:
    - Python version
    - OS type
    - Synapse client version
    - Service name and instance ID

Environment Variable Configuration:
    - `OTEL_SERVICE_NAME`: Defines a unique identifier for your application or service
      (defaults to 'synapseclient'). Set this to a descriptive name that represents your
      specific implementation for easier filtering and analysis.
    - `OTEL_EXPORTER_OTLP_ENDPOINT`: Specifies the destination URL for sending telemetry
      data (defaults to 'http://localhost:4318/v1/traces'). Configure this to direct
      traces to your preferred collector or monitoring service.
    - `OTEL_DEBUG_CONSOLE`: Controls local visibility of telemetry data. Set to 'true' to
      output trace information to the console for development and troubleshooting.
    - `OTEL_SERVICE_INSTANCE_ID`: Distinguishes between multiple instances of the same
      service (e.g., 'prod', 'development', 'local') to identify which specific
      deployment generated particular traces.
    - `OTEL_EXPORTER_OTLP_HEADERS`: Configures authentication and metadata for telemetry
      exports. Use this to add API keys, tokens, or custom metadata when sending traces
      to secured collectors.

Args:
    enable_open_telemetry_tracing: Whether to enable tracing (defaults to True).
    enable_open_telemetry_metrics: Whether to enable metrics collection (defaults to False).
    resource_attributes: Additional attributes to include with telemetry data, which can
        override environment variables like service name and instance ID.
    include_context: Whether to include runtime environment context (defaults to True).
}
\usage{
synEnableOpenTelemetry(enable_open_telemetry_tracing=TRUE, enable_open_telemetry_metrics=FALSE, resource_attributes=NULL, include_context=TRUE)
}
\arguments{
\item{enable_open_telemetry_tracing}{}
\item{enable_open_telemetry_metrics}{}
\item{resource_attributes}{}
\item{include_context}{}
}
\value{

}


