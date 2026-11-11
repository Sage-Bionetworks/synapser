test_that("gateway$invoke runs coroutine results to completion", {
  py <- reticulate::py_run_string(
    "
class _GatewayTestTarget:
    async def echo_async(self, value):
        return value

    def echo(self, value):
        return value

_gateway_test_target = _GatewayTestTarget()
",
    convert = FALSE
  )
  gateway <- reticulate::import("gateway")
  target <- py$`_gateway_test_target`

  expect_equal(
    "hello",
    gateway$invoke(method = list(target, "echo_async"), args = list("hello"), kwargs = list())
  )
  expect_equal(
    "hello",
    gateway$invoke(method = list(target, "echo"), args = list("hello"), kwargs = list())
  )
})
