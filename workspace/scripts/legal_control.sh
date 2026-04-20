#!/bin/bash
# 法律OPC案件权限控制工具
# 提供便捷的案件权限开关功能

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

CONFIG_FILE="$HOME/.openclaw/domains/legal-opc/.env"
BACKUP_DIR="$HOME/.openclaw/domains/legal-opc/backups"

show_help() {
    echo "⚖️  法律OPC案件权限控制工具"
    echo ""
    echo "用法: $0 [命令] [选项]"
    echo ""
    echo "命令:"
    echo "  status                    查看当前案件权限状态"
    echo "  enable                    启用案件受理"
    echo "  disable                   禁用案件受理"
    echo "  emergency                 紧急停止所有案件处理"
    echo "  client-add <name>         添加客户到黑名单"
    echo "  client-remove <name>      从黑名单移除客户"
    echo "  client-list               显示客户黑名单"
    echo "  quality-strict            设置严格质量控制"
    echo "  quality-normal            设置常规质量控制"
    echo "  backup                    备份当前配置"
    echo "  restore                   恢复最近的配置备份"
    echo "  help                      显示此帮助信息"
    echo ""
}

check_config_file() {
    if [ ! -f "$CONFIG_FILE" ]; then
        echo -e "${RED}❌ 配置文件不存在: $CONFIG_FILE${NC}"
        echo -e "${YELLOW}请先运行安装脚本安装法律OPC系统${NC}"
        exit 1
    fi
}

get_config() {
    local key=$1
    grep "^${key}=" "$CONFIG_FILE" 2>/dev/null | cut -d'=' -f2 | tr -d '"'
}

set_config() {
    local key=$1
    local value=$2
    if grep -q "^${key}=" "$CONFIG_FILE" 2>/dev/null; then
        sed -i "s/^${key}=.*/${key}=${value}/" "$CONFIG_FILE"
    else
        echo "${key}=${value}" >> "$CONFIG_FILE"
    fi
}

show_status() {
    echo -e "${BLUE}⚖️  法律OPC案件权限状态${NC}"
    echo "================================"

    # 案件受理状态
    case_intake=$(get_config "CASE_INTAKE_ENABLED")
    if [ "$case_intake" = "true" ]; then
        echo -e "案件受理: ${GREEN}✅ 已启用${NC}"
    else
        echo -e "案件受理: ${RED}❌ 已禁用${NC}"
    fi

    # 处理模式
    processing_mode=$(get_config "CASE_PROCESSING_MODE")
    echo -e "处理模式: ${BLUE}${processing_mode}${NC}"

    # 质量控制
    quality_control=$(get_config "QUALITY_CONTROL")
    echo -e "质量控制: ${BLUE}${quality_control}${NC}"

    # 客户黑名单
    blacklist=$(get_config "CLIENT_BLACKLIST")
    if [ -n "$blacklist" ]; then
        echo -e "\n🚫 客户黑名单:"
        echo "$blacklist" | tr ',' '\n' | sed 's/^/  - /'
    else
        echo -e "\n🚫 客户黑名单: ${GREEN}无${NC}"
    fi

    echo ""
}

case "$1" in
    status) show_status ;;
    enable) set_config "CASE_INTAKE_ENABLED" "true" && echo -e "${GREEN}✅ 案件受理已启用${NC}" ;;
    disable) set_config "CASE_INTAKE_ENABLED" "false" && echo -e "${GREEN}✅ 案件受理已禁用${NC}" ;;
    help|--help|-h) show_help ;;
    *) echo "用法: $0 [命令]"; show_help ;;
esac
