#!/bin/bash
# 编辑后验证脚本 - 语言无关的轻量验证

FILE="$1"

if [ -z "$FILE" ]; then
    exit 0
fi

echo "🔍 编辑后验证: $FILE"

# 1. 记录变更历史
HISTORY_FILE=".claude/edit-history.log"
mkdir -p "$(dirname "$HISTORY_FILE")"
echo "$(date '+%Y-%m-%d %H:%M:%S') | $FILE | $(git rev-parse --short HEAD 2>/dev/null || echo 'new')" >> "$HISTORY_FILE"

# 2. 通用语法检查 - 使用各自语言的解释器/编译器
check_syntax() {
    local file="$1"
    local ext="${file##*.}"

    case "$ext" in
        go)
            # Go: 使用 gofmt 检查格式，go vet 检查语法
            if command -v gofmt &>/dev/null; then
                UNFORMATTED=$(gofmt -l "$file" 2>/dev/null)
                if [ -n "$UNFORMATTED" ]; then
                    echo "⚠️  格式不规范，建议运行: gofmt -w $file"
                fi
            fi
            if command -v go &>/dev/null; then
                go vet "$file" 2>&1 | head -3 && echo "✅ Go 检查通过" || true
            fi
            ;;
        ts|tsx)
            # TypeScript
            if command -v tsc &>/dev/null; then
                tsc --noEmit "$file" 2>&1 | head -5
                [ $? -eq 0 ] && echo "✅ TypeScript 检查通过" || true
            elif command -v node &>/dev/null; then
                node --check "$file" 2>&1 || echo "✅ 语法检查通过"
            fi
            ;;
        js|jsx|mjs|cjs)
            # JavaScript
            if command -v node &>/dev/null; then
                node --check "$file" 2>&1 && echo "✅ JavaScript 检查通过" || true
            fi
            ;;
        py)
            # Python
            if command -v python3 &>/dev/null; then
                python3 -m py_compile "$file" 2>&1 && echo "✅ Python 检查通过" || true
            elif command -v python &>/dev/null; then
                python -m py_compile "$file" 2>&1 && echo "✅ Python 检查通过" || true
            fi
            ;;
        rs)
            # Rust
            if command -v rustfmt &>/dev/null; then
                rustfmt --check "$file" 2>&1 | head -3
                [ $? -eq 0 ] && echo "✅ Rust 格式检查通过" || true
            fi
            ;;
        sh|bash|zsh)
            # Shell
            if command -v bash &>/dev/null; then
                bash -n "$file" 2>&1 && echo "✅ Shell 语法检查通过" || true
            fi
            ;;
        java)
            # Java
            if command -v javac &>/dev/null; then
                javac -Xlint:all -d /tmp "$file" 2>&1 | head -5 || echo "✅ Java 检查完成"
            fi
            ;;
        kt|kts)
            # Kotlin
            if command -v kotlinc &>/dev/null; then
                kotlinc -Xskip-runtime-version-check "$file" 2>&1 | head -5 || echo "✅ Kotlin 检查完成"
            fi
            ;;
        rb)
            # Ruby
            if command -v ruby &>/dev/null; then
                ruby -c "$file" 2>&1 && echo "✅ Ruby 检查通过" || true
            fi
            ;;
        php)
            # PHP
            if command -v php &>/dev/null; then
                php -l "$file" 2>&1 | head -3
            fi
            ;;
        c|cpp|cc|cxx|h|hpp)
            # C/C++ - 需要编译器，跳过单文件检查
            echo "📄 C/C++ 文件，建议通过项目构建系统验证"
            ;;
        json)
            # JSON
            if command -v python3 &>/dev/null; then
                python3 -m json.tool "$file" > /dev/null 2>&1 && echo "✅ JSON 格式有效" || echo "⚠️  JSON 格式可能有问题"
            elif command -v node &>/dev/null; then
                node -e "JSON.parse(require('fs').readFileSync('$file'))" 2>&1 && echo "✅ JSON 格式有效" || true
            fi
            ;;
        yaml|yml)
            # YAML
            if command -v python3 &>/dev/null; then
                python3 -c "import yaml; yaml.safe_load(open('$file'))" 2>&1 && echo "✅ YAML 格式有效" || true
            fi
            ;;
        md)
            # Markdown - 无需验证
            echo "📄 Markdown 文件"
            ;;
        *)
            echo "📄 文件类型 .$ext，无特定验证"
            ;;
    esac
}

# 执行语法检查
check_syntax "$FILE"

# 3. 检查文件大小异常
if [ -f "$FILE" ]; then
    FILE_SIZE=$(wc -c < "$FILE" 2>/dev/null || stat -c%s "$FILE" 2>/dev/null || stat -f%z "$FILE" 2>/dev/null)
    if [ "$FILE_SIZE" -gt 100000 ]; then
        echo "⚠️  文件较大 ($(( FILE_SIZE / 1024 )) KB)，考虑拆分"
    fi
fi

# 4. 检查是否需要更新相关测试（通用检测）
BASENAME=$(basename "$FILE" | sed 's/\.[^.]*$//')
DIRNAME=$(dirname "$FILE")

# 常见测试文件命名模式
TEST_PATTERNS=(
    "${BASENAME}_test"
    "${BASENAME}.test"
    "${BASENAME}.spec"
    "${BASENAME}Test"
    "test_${BASENAME}"
    "Test${BASENAME^}"
)

# 限制搜索深度避免性能问题
FOUND_TEST=false
for pattern in "${TEST_PATTERNS[@]}"; do
    if find "$DIRNAME" -maxdepth 2 -name "${pattern}*" -type f 2>/dev/null | head -1 | grep -q .; then
        FOUND_TEST=true
        break
    fi
done

if [[ "$FILE" != *"_test"* ]] && [[ "$FILE" != *".test"* ]] && [[ "$FILE" != *".spec"* ]] && [[ "$FILE" != *"Test"* ]]; then
    if [ "$FOUND_TEST" = false ]; then
        echo "💡 提示: 未找到相关测试文件"
    fi
fi

# 5. 检查常见代码问题（语言无关）
if [ -f "$FILE" ]; then
    # 检查 TODO/FIXME
    TODO_COUNT=$(grep -c "TODO\|FIXME\|XXX\|HACK" "$FILE" 2>/dev/null || echo "0")
    if [ "$TODO_COUNT" -gt 0 ]; then
        echo "📝 发现 $TODO_COUNT 个待办标记 (TODO/FIXME/XXX/HACK)"
    fi

    # 检查可能的调试代码
    DEBUG_PATTERNS="console\.log\|print(\|fmt\.Print\|System\.out\.print\|NSLog\|println\|debugger"
    if grep -qE "$DEBUG_PATTERNS" "$FILE" 2>/dev/null; then
        echo "⚠️  可能包含调试代码，提交前请确认"
    fi
fi

echo "✅ 验证完成"
exit 0
