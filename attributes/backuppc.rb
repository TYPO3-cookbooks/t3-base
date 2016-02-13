#<> SSH user used for logins of the backup server
default['backuppc']['user'] = "t3o-backup"
#<> SSH keys allowing the server to login
default['backuppc']['user_ssh_pubkeys'] = [
  "command=\"sudo $SSH_ORIGINAL_COMMAND\" ssh-dss AAAAB3NzaC1kc3MAAACBAIV5OCUoJjsYLZ5kN/hEmUkcrJw/sLS+VTXg7N0HBVNChwgZEW/uizYbEcl/OWi0HplVYfG3WX1u8X6wWhajrxrTizMaNGoVvUXur/s/SNEW6fg6JKPrIswV0NuWyrwPmzO9582KAa7WU7sBIO0FpiadcU+Srz+eUUap1dYH2eHvAAAAFQCjn7rZdpaoqIbbQJIo2ZlygVt+JwAAAIBcIosaN7RR3Ytc4Fx58do18tSlsFqoQuiafh6iof73hPP/cEwWQRDgXzfmcmkgZne4ijc39TcZAinOJNAO4Em4H4BuPsKyjLj1ST6slvGWtHxyXxrca9yeNSMnOdn2ZhQU7caFqb1nee1m6UlpuBvHz5MShYCpvpAyDtNjxXbg0QAAAIAf6RUuCpR4/uCMtL5mJ53HKBlmVHmF2RemjpcOetb+xGTZHkG9ikMePNQTn23mpLW+ZguI6TIpBkeYUyPj0OT6im+PgOaN7iQOngCINCGnC9+aMKnCIvk3lLs77fcNYKhKZOLZm6O3ODhKkBKN9GJNCVB/qOEjhd5mECJrSWytEA== backuppc@backup01.typo3.org-2012-10-30T08:19:12+0100"
]