EXCEPTION_MESSAGE_BOUNDARY='exception-message-boundary'

def abbreviateStackTrace(function):
    exceptionToRaise = None
    try:
        return function()
    except Exception as e:
        exceptionToRaise = e     
    # We do this to suppress the automatic exception chaining that occurs when rethrowing
    # with an 'except' block
    if exceptionToRaise is not None:
        raise Exception(EXCEPTION_MESSAGE_BOUNDARY+str(exceptionToRaise)+EXCEPTION_MESSAGE_BOUNDARY)
