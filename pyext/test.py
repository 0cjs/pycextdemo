import sys
import phello

def assert_equal(expected, actual, message):
    if expected == actual:
        return
    print('    test:', message)
    print('expected:', expected)
    print('  actual:', actual)
    print('FAIL')
    sys.exit(1)

def runtests():
    assert_equal(7, phello.seven(), 'seven()')
    assert_equal('Hello, Joe.', phello.greet('Joe'), 'greet(Joe)')

if __name__ == '__main__':
    runtests()
