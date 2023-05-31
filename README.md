# Tmux-SSH-Agent-Forwarding
This is a small practical demo code to address the long-standing issue about agent forwarding failure in a remote server's tmux environment.


## Background
The mechanism of SSH agent forwarding is highly useful on remote servers. However, there is a common issue that arises when using tmux. After host disconnecting, the tmux session retains the old SSH_AUTH_SOCK, rendering the SSH agent forwarding ineffective for that particular session. To address this issue, I have devised a solution based on my current practices and implemented it separately for reference.


## HOW-TO
You need to place the `scripts` folder in the relative paths specified within tmux.conf.

In my personal environment, it is set up as follows:

```
.
├── .local
│  └── scripts
├── .tmux.conf
└── .zshrc
```

## Explain
The major idea is to use symbolic link to ensure that the SSH_AUTH_SOCK within the tmux environment remains the same as the client that is still attached.
> All symbolic files are placed under ~/.ssh

In my design, the use of a double symbolic link achieves the following benefits:

1. Ensures that different sessions do not interfere with each other.
2. When different clients attach to the same session, if one of them detaches, it can relink back to the still attached client. This is an edge case, but for the sake of precaution, I have still implemented this design and this is why I use double link instead of single one.
3. There are specific timing for cleaning up invalid links. To avoid impacting performance, I only perform these checks at appropriate times. However, it is inevitable that some invalid files, which were not anticipated at the time of confirmation, may still remain without being cleared. They will be addressed during the next event trigger. For detailed information on the cleaning mechanism, you can refer to the hook I have binding and its corresponding scripts.

## Relative links
- https://gist.github.com/jvkersch/e7ef80dea675524d332f
- https://gist.github.com/martijnvermaat/8070533
- https://stackoverflow.com/questions/21378569/how-to-auto-update-ssh-agent-environment-variables-when-attaching-to-existing-tm

