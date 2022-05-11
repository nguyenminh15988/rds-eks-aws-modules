# Architecture
![image](https://user-images.githubusercontent.com/57975571/163742335-2b05f6a2-8be0-4f85-bf44-4831c30b1510.png)

# CI/CD
Not implement yet
![image](https://user-images.githubusercontent.com/57975571/163742436-ddedcc74-e766-4e70-aaab-bdc8e87eacbf.png)


# Provision an infrastrure by terraform 
using aws module

infrastructure:
- Network: VPC, PrivateSubnet, PublicSubnet 
- Route53
- EKS cluster ( ingress controller , deployment file, deployment rollingupdate )
- RDS

# Things to add
1. Cluster autoscaling
2. Route 53 management
3. Private API access
4. Cloudfront
5. RDS read replicas
6. Add more worker group difference instance type or managed group
7. TLS cert management
8. Monitoring and Alert
9. Install Jenkins on eks and configuration deployment pipeline
10. Intall ELK using helm and configuration log for monitoring 

