#!/bin/sh
# (C) by Filip M. Noetzel

test_description='Test git overlook'

GIT_OVERLOOK_DIR=`pwd`

cd /tmp/git/t/

. ./test-lib.sh

mkdir -p $TEST_DIRECTORY

test_create_repo test1 && pushd test1 > /dev/null

test_expect_success 'create simple overlook' "
        echo 1 > file &&
        $GIT_OVERLOOK_DIR/ogit add file &&
        $GIT_OVERLOOK_DIR/ogit commit -m initial &&
        echo 2 > file &&
        $GIT_OVERLOOK_DIR/ogit add file &&
        $GIT_OVERLOOK_DIR/git-overlook create
"

popd >/dev/null && test_create_repo test2 && pushd test2 > /dev/null

test_expect_success 'create simple overlook, then show' "
        echo config__example > file &&
        $GIT_OVERLOOK_DIR/ogit add file &&
        $GIT_OVERLOOK_DIR/ogit commit -m initial &&
        echo config__mysecret > file &&
        $GIT_OVERLOOK_DIR/ogit add file &&
        $GIT_OVERLOOK_DIR/git-overlook create && 
        $GIT_OVERLOOK_DIR/git-overlook show
"

popd > /dev/null && test_create_repo test3 && pushd test3 > /dev/null

test_expect_success 'simple overlook, no index then' "
        echo config__example > file &&
        $GIT_OVERLOOK_DIR/ogit add file &&
        $GIT_OVERLOOK_DIR/ogit commit -m initial &&
        echo config__mysecret > file &&
        $GIT_OVERLOOK_DIR/ogit add file &&
        $GIT_OVERLOOK_DIR/git-overlook create &&
	$GIT_OVERLOOK_DIR/ogit diff --cached --quiet
"

# test_must_fail $GIT_OVERLOOK_DIR/ogit diff-files --quiet &&

popd > /dev/null && test_create_repo test4 && pushd test4 > /dev/null

cat > expected << EOF

diff --git a/file b/file
index 4c2a95f..835094d 100644
--- a/file
+++ b/file
@@ -1 +1 @@
-config__example
+config__mysecret
EOF

test_expect_success 'simple overlook, verify git-overlook show output' "
        echo config__example > file &&
        $GIT_OVERLOOK_DIR/ogit add file &&
        $GIT_OVERLOOK_DIR/ogit commit -m initial &&
        echo config__mysecret > file &&
        $GIT_OVERLOOK_DIR/ogit add file &&
        $GIT_OVERLOOK_DIR/git-overlook create &&
        $GIT_OVERLOOK_DIR/git-overlook show | tail -n +6 > actual &&
        test_cmp expected actual
"

test_done
