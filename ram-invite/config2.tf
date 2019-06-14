provider "aws" {
  region  = "us-east-1"
  profile = "mock"
}

resource "aws_ram_resource_share_accepter" "this" {
  share_arn  = "arn:aws:ram:us-east-1:${var.account_id}:resource-share/a4b56d7d-807f-5653-e6db-e1f51ba5ddd6"
}

	/*
		conn := meta.(*AWSClient).ramconn

		requestInput := &ram.RejectResourceShareInvitationInput{
			ClientToken: aws.String(resource.UniqueId()),
		}

		if v, ok := d.GetOk("invitation_arn"); ok {
			requestInput.ResourceShareInvitationArn = aws.String(v.(string))
		} else if v, ok := d.GetOk("share_arn"); ok {
			// need to find invitation arn
			invitationARN, err := resourceAwsRamResourceShareGetInvitationARN(conn, v.(string))
			if err != nil {
				return err
			}

			requestInput.ResourceShareInvitationArn = invitationARN
		} else {
			return fmt.Errorf("Either an invitation ARN or share ARN are required")
		}

		log.Println("[DEBUG] Reject RAM resource share invitation request:", requestInput)
		_, err := conn.RejectResourceShareInvitation(requestInput)
		if err != nil {
			return fmt.Errorf("Error rejecting RAM resource share invitation: %s", err)
		}

		stateConf := &resource.StateChangeConf{
			Pending: []string{ram.ResourceShareInvitationStatusPending},
			Target:  []string{ram.ResourceShareInvitationStatusRejected},
			Refresh: resourceAwsRamResourceShareAccepterStateRefreshFunc(conn, d.Id()),
			Timeout: d.Timeout(schema.TimeoutCreate),
		}

		_, err = stateConf.WaitForState()
		if err != nil {
			return fmt.Errorf("Error waiting for RAM resource share invitation (%s) state: %s", d.Id(), err)
		}
		d.SetId("")

		return resourceAwsRamResourceShareAccepterRead(d, meta)
	*/


/*
AFTER SHARE CREATED, BEFORE ACCEPT:
{
    "resourceShareInvitations": [
        {
            "resourceShareInvitationArn": "arn:aws:ram:us-east-1:${var.account_id}:resource-share-invitation/6eb56b8d-a3cb-0644-b0e5-bd2c62c272af",
            "resourceShareName": "vize",
            "resourceShareArn": "arn:aws:ram:us-east-1:${var.account_id}:resource-share/1cb56b8d-a2ce-6a63-fb91-05afc90ed7c0",
            "senderAccountId": "${var.account_id}",
            "receiverAccountId": "${var.mock_account_id}",
            "invitationTimestamp": 1558387050.393,
            "status": "PENDING"
        }
    ]
}

{
    "resourceShares": []
}

AFTER ACCEPT:
{
    "resourceShareInvitations": [
        {
            "resourceShareInvitationArn": "arn:aws:ram:us-east-1:${var.account_id}:resource-share-invitation/6eb56b8d-a3cb-0644-b0e5-bd2c62c272af",
            "resourceShareName": "vize",
            "resourceShareArn": "arn:aws:ram:us-east-1:${var.account_id}:resource-share/1cb56b8d-a2ce-6a63-fb91-05afc90ed7c0",
            "senderAccountId": "${var.account_id}",
            "receiverAccountId": "${var.mock_account_id}",
            "invitationTimestamp": 1558394710.467,
            "status": "ACCEPTED"
        }
    ]
}

# from receiver
$ aws ram get-resource-shares --resource-owner OTHER-ACCOUNTS
{
    "resourceShares": [
        {
            "resourceShareArn": "arn:aws:ram:us-east-1:${var.account_id}:resource-share/aeb56d18-1711-3974-93c6-633dbc817136",
            "name": "coldplay",
            "owningAccountId": "${var.account_id}",
            "allowExternalPrincipals": true,
            "status": "ACTIVE",
            "creationTime": 1558438751.811,
            "lastUpdatedTime": 1558438751.811
        }
    ]
}

AFTER DELETE:
{
    "resourceShareInvitations": [
        {
            "resourceShareInvitationArn": "arn:aws:ram:us-east-1:${var.account_id}:resource-share-invitation/6eb56b8d-a3cb-0644-b0e5-bd2c62c272af",
            "resourceShareName": "vize",
            "resourceShareArn": "arn:aws:ram:us-east-1:${var.account_id}:resource-share/1cb56b8d-a2ce-6a63-fb91-05afc90ed7c0",
            "senderAccountId": "${var.account_id}",
            "receiverAccountId": "${var.mock_account_id}",
            "invitationTimestamp": 1558394710.467,
            "status": "ACCEPTED"
        }
    ]
}

$ aws ram get-resource-shares --resource-owner OTHER-ACCOUNTS
{
    "resourceShares": []
}

/*
func resourceAwsRamResourceShareAccepterDelete(d *schema.ResourceData, meta interface{}) error {
	d.SetId("")
	log.Printf("[WARN] Will not delete resource share invitation. Terraform will remove this invitation accepter from the state file. However, resources may remain.")
	return nil
}
*/
