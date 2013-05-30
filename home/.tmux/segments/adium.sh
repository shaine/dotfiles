run_segment() {
    local chats
    chats=$(__chats_adium)
    local exitcode="$?"
    if [ "$exitcode" -ne 0 ]; then
        return $exitcode
    fi

    if [[ -n "$chats" ]]; then
        echo "💬  ${chats}"
    fi

    return 0
}

__chats_adium() {
    chats=$(${TMUX_POWERLINE_DIR_USER_SEGMENTS}adium.script)
    echo "$chats"
}
