-- generate C test file to check type sizes etc
-- luajit ctest.lua > ctest.c && cc ctest.c -o ctest && ./ctest

local S = require "syscall"
local ffi = require "ffi"

local s, t, c, ctypes = S.s, S.t, S.c, S.ctypes

-- TODO fix these, various naming issues
ctypes["struct linux_dirent64"] = nil
ctypes["struct statfs64"] = nil
ctypes["struct flock64"] = nil
ctypes["struct stat64"] = nil
ctypes["struct fdb_entry"] = nil
ctypes["struct seccomp_data"] = nil
ctypes["sighandler_t"] = nil
ctypes["struct rlimit64"] = nil
ctypes["struct mq_attr"] = nil
ctypes["int errno"] = nil

-- TODO seems to be an issue with sockaddr_storage (alignment difference?) on Musl, needs fixing
ctypes["struct sockaddr_storage"] = nil
-- TODO seems to be a size issue on Musl
ctypes["struct siginfo"] = nil
-- TODO seems to be a size issue on Musl, have asked list
ctypes["struct sysinfo"] = nil

-- missing on my ARM box
c.CAP = nil
c.AF.NFC = nil
c.PR.SET_PTRACER = nil
c.MAP["32BIT"] = nil
c.SYS.sync_file_range = nil

-- fake constants
c.MS.RO = nil
c.MS.RW = nil
c.IFF.ALL = nil
c.IFF.NONE = nil
c.W.ALL = nil

-- umount is odd
c.MNT = {}
c.MNT.FORCE = c.UMOUNT.FORCE
c.MNT.DETACH = c.UMOUNT.DETACH
c.MNT.EXPIRE = c.UMOUNT.EXPIRE
c.UMOUNT.FORCE = nil
c.UMOUNT.DETACH = nil
c.UMOUNT.EXPIRE = nil

-- TODO find the headers/flags for these if exist, or remove
c.SA.RESTORER = nil
c.AF.DECNET = nil
c.SIG.HOLD = nil
c.NOTHREAD = nil
c.RTF.PREFIX_RT = nil
c.RTF.EXPIRES = nil
c.RTF.ROUTEINFO = nil
c.RTF.ANYCAST = nil
c.W.CLONE = nil
c.W.NOTHREAD = nil

-- fix these, renamed tables, signals etc
c.SIGTRAP = nil
c.SIGPM = nil
c.SIGILL = nil
c.SIGPOLL = nil
c.SIGCLD = nil
c.SIGFPE = nil
c.SIGSEGV = nil
c.SIGBUS = nil
c.SIGACT = nil

c.SECCOMP_MODE = nil
c.NLMSG_NEWLINK = nil
c.AT_FSTATAT = nil
c.LOCKF = nil
c.AT_SYMLINK_FOLLOW = nil
c.AT_REMOVEDIR = nil
c.AT_SYMLINK_NOFOLLOW = nil
c.SIOC = nil
c.TIOC = nil
c.IFLA_VF_INFO = nil
c.IFLA_VF_PORT = nil
c.TCFLOW = nil
c.TCSA = nil
c.FCNTL_LOCK = nil
c.TCFLUSH = nil
c.SECCOMP_RET = nil
c.IN_INIT = nil
c.PR_MCE_KILL_OPT = nil
c.OK = nil
c.EPOLLCREATE = nil
c.STD = nil
c.PORT_PROFILE_RESPONSE = nil
c.AT_FDCWD = nil
c.AT_ACCESSAT = nil
c.NLMSG_GETLINK = nil
c.SYS.fstatat = nil
c.TFD = nil
c.TFD_TIMER = nil

-- this lot are not in uClibc at present
c.ADJ.OFFSET_SS_READ = nil
c.ADJ.NANO = nil
c.ADJ.MICRO = nil
c.ADJ.TAI = nil
c.F.GETPIPE_SZ = nil
c.F.GETOWN_EX = nil
c.F.SETOWN_EX = nil
c.F.SETPIPE_SZ = nil
c.AF.RDS = nil
c.MS.MOVE = nil
c.MS.PRIVATE = nil
c.MS.ACTIVE = nil
c.MS.POSIXACL = nil
c.MS.RELATIME = nil
c.MS.NOUSER = nil
c.MS.SLAVE = nil
c.MS.I_VERSION = nil
c.MS.KERNMOUNT = nil
c.MS.SHARED = nil
c.MS.STRICTATIME = nil
c.MS.UNBINDABLE = nil
c.MS.DIRSYNC = nil
c.MS.SILENT = nil
c.MS.REC = nil
c.RLIMIT.RTTIME = nil
c.UMOUNT.NOFOLLOW = nil
c.STA.MODE = nil
c.STA.CLK = nil
c.STA.NANO = nil
c.CLOCK.MONOTONIC_COARSE = nil
c.CLOCK.REALTIME_COARSE = nil
c.CLOCK.MONOTONIC_RAW = nil
c.SOCK.DCCP = nil

-- these are not in Musl at present TODO send patches to get them in
c.IPPROTO.UDPLITE = nil
c.IPPROTO.DCCP = nil
c.IPPROTO.SCTP = nil
c.CIBAUD = nil
c.F.GETLEASE = nil
c.F.SETLK64 = nil
c.F.NOTIFY = nil
c.F.SETLEASE = nil
c.F.GETLK64 = nil
c.F.SETLKW64 = nil
c.AF.LLC = nil
c.AF.TIPC = nil
c.AF.CAN = nil
c.MSG.TRYHARD = nil
c.MSG.SYN = nil
c.PR_TASK_PERF_EVENTS = nil
c.PR.MCE_KILL = nil
c.PR.MCE_KILL_GET = nil
c.PR.TASK_PERF_EVENTS_ENABLE = nil
c.PR.TASK_PERF_EVENTS_DISABLE = nil
c.PR_ENDIAN.LITTLE = nil
c.PR_ENDIAN.BIG = nil
c.PR_ENDIAN.PPC_LITTLE = nil
c.SIG.IOT = nil
c.SIG.CLD = nil
c.__MAX_BAUD = nil
c.O.FSYNC = nil
c.RLIMIT.OFILE = nil
c.SO.SNDBUFFORCE = nil
c.SO.RCVBUFFORCE = nil
c.POLL.REMOVE = nil
c.POLL.RDHUP = nil
c.PR_MCE_KILL.SET = nil
c.PR_MCE_KILL.CLEAR = nil
c.EXTA = nil
c.EXTB = nil
c.XCASE = nil
c.IUTF8 = nil
c.CMSPAR = nil
c.IN.EXCL_UNLINK = nil
c.MNT.EXPIRE = nil
c.MNT.DETACH = nil
c.SYS.fadvise64_64 = nil

-- Musl changes some of the syscall constants in its 32/64 bit handling
c.SYS.getdents = nil

-- Musl ors O.ACCMODE with O_SEARCH TODO why?
c.O.ACCMODE = nil

if ffi.abi("64bit") then c.O.LARGEFILE = nil end

-- renamed constants
c.O.NONBLOCK = c.OPIPE.NONBLOCK
c.O.CLOEXEC = c.OPIPE.CLOEXEC
c.OPIPE = nil

-- include kitchen sink, garbage can etc
print [[
/* this code is generated by ctest.lua */

#define _GNU_SOURCE
#define __USE_GNU
#define _FILE_OFFSET_BITS 64
#define _LARGE_FILES 1
#define __USE_FILE_OFFSET64

#include <limits.h>
#include <assert.h>
#include <errno.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <sys/epoll.h>
#include <signal.h>
#include <sys/utsname.h>
#include <time.h>
#include <sys/resource.h>
#include <sys/sysinfo.h>
#include <sys/time.h>
#include <sys/un.h>
#include <netinet/ip.h>
#include <poll.h>
#include <sys/signalfd.h>
#include <sys/vfs.h>
#include <sys/timex.h>
#include <sys/mman.h>
#include <sched.h>
#include <sys/xattr.h>
#include <termios.h>
#include <unistd.h>
#include <sys/prctl.h>
#include <sys/mount.h>
#include <sys/uio.h>
#include <net/route.h>
#include <sys/inotify.h>
#include <sys/wait.h>
#include <dirent.h>
#include <sys/eventfd.h>
#include <syscall.h>

#include <linux/aio_abi.h>
#include <linux/reboot.h>
#include <linux/falloc.h>
#include <linux/mman.h>
#include <linux/veth.h>
#include <linux/sockios.h>
#include <linux/if_arp.h>
#include <linux/sched.h>
#include <linux/posix_types.h>
#include <linux/if.h>
#include <linux/if_bridge.h>
#include <linux/rtnetlink.h>

int main(int argc, char **argv) {
]]

-- iterate over S.ctypes
for k, v in pairs(ctypes) do
  print("assert(sizeof(" .. k .. ") == " .. ffi.sizeof(v) .. ");")
end

-- test all the constants

-- renamed ones
local nm = {
  E = "E",
  SIG = "SIG",
  EPOLL = "EPOLL",
  STD = "STD",
  MODE = "S_I",
  MSYNC = "MS_",
  W = "W",
  POLL = "POLL",
  S_I = "S_I",
  LFLAG = "",
  IFLAG = "",
  OFLAG = "",
  CFLAG = "",
  CC = "",
  IOCTL = "",
  B = "B",
}

for k, v in pairs(c) do
  if type(v) == "number" then
    print("assert(" .. k .. " == " .. v .. ");")
  elseif type(v) == "table" then
    for k2, v2 in pairs(v) do
      local name = nm[k] or k .. "_"
      print("assert(" .. name .. k2 .. " == " .. tostring(v2) .. ");")
    end
  end
end

-- TODO test error codes

print [[
}
]]

