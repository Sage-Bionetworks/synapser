%
%  Auto-generated file, do not modify.
%  Instead, copy this file to the man/ folder, remove this warning, and edit freely.
%  Use Git to identify changes in this file which suggest where to change your edited copy.
%
\name{synGetTracer}
\alias{synGetTracer}
\docType{methods}
\title{
synGetTracer
}
\description{
Returns an OpenTelemetry tracer that can be used to create spans and collect telemetry data.

The tracer allows you to create custom spans to track specific operations in your code,
making it easier to analyze performance and troubleshoot issues. You can create spans,
add attributes, events, and links to provide rich context about your application's behavior.

Note: OpenTelemetry must be enabled via `Synapse.enable_open_telemetry()` before using this method.

Args:
    name: Optional name for the tracer. If not provided, the default Synapse tracer is used.
         Use this to create separate tracers for different components of your application.

Returns:
    An OpenTelemetry Tracer instance that can be used to create spans.
}
\usage{
synGetTracer(name=NULL)
}
\arguments{
\item{name}{}
}
\value{

}


