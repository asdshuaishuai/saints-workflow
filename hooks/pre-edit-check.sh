#!/bin/bash
# 编辑前检查脚本 - 语言无关的护栏机制

FILE="$1"

if [ -z "$FILE" ]; then
    exit 0
fi

echo "🔍 编辑前检查: $FILE"

# 1. 新文件检查
if [ ! -f "$FILE" ]; then
    echo "📝 新文件，跳过检查"
    exit 0
fi

# 2. 测试文件直接放行（通用测试文件命名）
if [[ "$FILE" == *_test.* ]] || [[ "$FILE" == *".test."* ]] || [[ "$FILE" == *".spec."* ]] || [[ "$FILE" == *"Test."* ]] || [[ "$FILE" == *"test_"* ]]; then
    echo "🧪 测试文件，允许编辑"
    exit 0
fi

# 3. 保护关键配置和依赖文件
FILENAME=$(basename "$FILE")
PROTECTED_PATTERNS=(
    "go.mod" "go.sum"
    "package.json" "package-lock.json" "yarn.lock" "pnpm-lock.yaml"
    "Cargo.toml" "Cargo.lock"
    "requirements.txt" "Pipfile" "Pipfile.lock" "poetry.lock"
    "pom.xml" "build.gradle" "build.gradle.kts"
    "Gemfile" "Gemfile.lock"
    "composer.json" "composer.lock"
    ".gitignore" ".gitattributes"
    "Makefile" "CMakeLists.txt"
)

for protected in "${PROTECTED_PATTERNS[@]}"; do
    if [[ "$FILENAME" == "$protected" ]]; then
        echo "⚠️  警告: 正在修改依赖/配置文件 $FILE"
        echo "   建议: 使用专门的依赖管理命令"
        # 记录警告但不阻止
        mkdir -p .claude
        echo "[WARN] $(date '+%Y-%m-%d %H:%M:%S'): 依赖文件修改 $FILE" >> .claude/edit-warnings.log
    fi
done

# 4. 检查文件锁（防止并发编辑冲突）
if [ -f "$FILE.lock" ]; then
    LOCK_PID=$(cat "$FILE.lock" 2>/dev/null)
    if [ -n "$LOCK_PID" ]; then
        # 跨平台的进程检测
        IS_RUNNING=false
        if kill -0 "$LOCK_PID" 2>/dev/null; then
            IS_RUNNING=true
        elif command -v ps &>/dev/null; then
            if ps -p "$LOCK_PID" > /dev/null 2>&1; then
                IS_RUNNING=true
            fi
        fi

        if [ "$IS_RUNNING" = true ]; then
            echo "❌ 文件被锁定 (PID: $LOCK_PID)，可能有其他agent正在编辑"
            exit 1
        else
            echo "🧹 清理过期锁文件"
            rm -f "$FILE.lock"
        fi
    fi
fi

# 5. 备份重要配置文件
if [[ "$FILE" == *"config"* ]] || [[ "$FILE" == *".env"* ]] || [[ "$FILE" == *".yaml"* ]] || [[ "$FILE" == *".yml"* ]] || [[ "$FILE" == *".toml"* ]] || [[ "$FILE" == *".ini"* ]]; then
    BACKUP_DIR=".claude/backups"
    mkdir -p "$BACKUP_DIR"

    # 清理文件名中的特殊字符，防止路径问题
    SAFE_NAME=$(echo "$FILENAME" | sed 's/[^a-zA-Z0-9._-]/_/g')
    BACKUP_FILE="$BACKUP_DIR/${SAFE_NAME}.$(date +%Y%m%d_%H%M%S).bak"

    cp "$FILE" "$BACKUP_FILE" 2>/dev/null
    echo "📦 已备份到: $BACKUP_FILE"
fi

# 6. 检查文件是否为二进制文件
if [ -f "$FILE" ]; then
    if file "$FILE" 2>/dev/null | grep -q "binary\|executable\|compiled"; then
        echo "⚠️  警告: 这可能是二进制文件，编辑可能导致损坏"
    fi
fi

echo "✅ 检查通过"
exit 0
