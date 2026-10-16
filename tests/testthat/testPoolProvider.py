import synapseclient

def print_x(x):
    print(x)

def test():
  mp = synapseclient.core.pool_provider.get_executor()
  try:
    list(mp.map(print_x, range(1, 100)))
  finally:
    mp.shutdown()
